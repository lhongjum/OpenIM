package router

import (
	"github.com/gin-gonic/gin"

	"backend/controller"
)


func setChatRoutes(r *gin.RouterGroup) {
	r.GET("/chat", controller.ChatController)
}
