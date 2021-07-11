package app

import (
	"github.com/gin-gonic/gin"

	"backend/router"
)

func New() error {
	r := gin.Default()
	router.SetRouter(r)

	return r.Run()
}
