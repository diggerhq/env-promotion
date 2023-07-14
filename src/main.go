package main

import (
	"fmt"
	"github.com/alextanhongpin/go-gin-starter/config"
	"github.com/gin-gonic/gin"
	"net/http"
	"os"
)

func newRouter() *gin.Engine {
	r := gin.Default()
	return r
}

func main() {
	cfg := config.New()
	cfg.AutomaticEnv()

	r := gin.Default()

	version, _ := os.ReadFile("version.txt")
	r.GET("/health", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"build_date":  cfg.GetString("build_date"),
			"deployed_at": cfg.GetString("deployed_at"),
			"version":     string(version),
		})
	})


	r.Run(fmt.Sprintf(":%d", cfg.GetInt("port")))
}
