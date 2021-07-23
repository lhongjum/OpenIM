package middleware

import "github.com/gin-gonic/gin"

func SetGlobal(r *gin.Engine) {
	r.Use(Cors())
}
