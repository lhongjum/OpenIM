package router

import "github.com/gin-gonic/gin"


// 给应用设置路由
func SetRouter(r *gin.Engine) {
	v1 := r.Group("/v1")
	setAuthRoutes(v1)
	setChatRoutes(v1)
	setUserRoutes(v1)
}
