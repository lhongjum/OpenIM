package controller

import (
	"net/http"
	"strconv"
	"sync"

	"github.com/gin-gonic/gin"
	"github.com/gorilla/websocket"
)

const (
	DeviceMobile DeviceType = iota
	DeviceDesktop
	DeviceWeb
)

var (
	upgrader = &websocket.Upgrader{
		CheckOrigin: func(r *http.Request) bool {
			return true
		},
	}

	scheduler = &Scheduler{
		connMap: make(map[int]map[DeviceType]*websocket.Conn),
		lock:    sync.RWMutex{},
	}
)

func ChatController(c *gin.Context) {
	conn, err := upgrader.Upgrade(c.Writer, c.Request, nil)
	if err != nil {
		// TODO: 直接返回errno
		return
	}
	defer conn.Close()

	// TODO: 解析出用户uid和当前设备类型两个参数
	num1, _ := strconv.Atoi(c.Query("fid"))
	scheduler.Join(conn, num1, NewDeviceType(0)) // 用户WS登录
	defer scheduler.Exit(num1, NewDeviceType(0)) // 用户WS退出
	num2, _ := strconv.Atoi(c.Query("tid"))

	for {
		_, data, err := conn.ReadMessage()
		if err != nil {
			// 如果获取消息失败，那就断开该登录连接
			return
		}
		// TODO: 解析出读取的消息，按type字段进行类型断言，进行对应操作

		scheduler.SendChatMsg(num1, num2, data)
	}
}

type DeviceType int8

func NewDeviceType(no int) DeviceType {
	return DeviceType(no)
}

func (d DeviceType) String() string {
	return strconv.Itoa(int(d))
}

// Scheduler 调度所有平台的Websocket连接
type Scheduler struct {
	connMap map[int]map[DeviceType]*websocket.Conn
	lock    sync.RWMutex
}

// Join 添加新WS连接，即用户登录
func (s *Scheduler) Join(conn *websocket.Conn, uid int, deviceType DeviceType) {
	s.lock.Lock()
	defer s.lock.Unlock()

	if _, ok := s.connMap[uid]; !ok {
		s.connMap[uid] = make(map[DeviceType]*websocket.Conn)
	}
	s.connMap[uid][deviceType] = conn
}

// Exit 删除WS连接：即用户退出
func (s *Scheduler) Exit(uid int, deviceType DeviceType) {
	s.lock.Lock()
	defer s.lock.Unlock()

	delete(s.connMap[uid], deviceType)
}

// IsExist 查看用户是否在某个平台上登录
func (s *Scheduler) IsExist(uid int, deviceType DeviceType) bool {
	s.lock.RLock()
	defer s.lock.RUnlock()

	_, ok := s.connMap[uid][deviceType]
	return ok
}

// SendChatMsg 发送普通聊天消息
func (s *Scheduler) SendChatMsg(fuid, tuid int, message []byte) {
	if s.connMap[tuid] == nil || len(s.connMap[tuid]) == 0 {
		// TODO: 满足此条件，说明用户在各平台都没有登陆。要把消息存在数据库里，等到用户登录再后拉取
		return
	}

	// 给`对方`的设备`发送`内容
	for deviceType, conn := range s.connMap[tuid] {
		if err := conn.WriteMessage(websocket.TextMessage, []byte(message)); err != nil {
			conn.Close()
			s.Exit(fuid, deviceType)
		}
	}

	// 给`自己`的设备`同步`内容
	for deviceType, conn := range s.connMap[fuid] {
		if err := conn.WriteMessage(websocket.TextMessage, []byte(message)); err != nil {
			conn.Close()
			s.Exit(fuid, deviceType)
		}
	}
}
