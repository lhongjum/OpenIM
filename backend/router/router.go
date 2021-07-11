package router

import "github.com/gin-gonic/gin"


// 给应用设置路由
func SetRouter(r *gin.Engine) {
	setAuthRoutes(r)
	setChatRoutes(r)
	setDiskRoutes(r)
	setUserRoutes(r)
}
