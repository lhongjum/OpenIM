package app

import (
	"github.com/gin-gonic/gin"

	"backend/middleware"
	"backend/router"
)

func New() error {
	r := gin.Default()

	middleware.SetGlobal(r)
	router.SetRouter(r)

	return r.Run()
}
