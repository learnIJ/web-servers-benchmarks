package main

import (
	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/log"
	"github.com/gofiber/fiber/v2/middleware/logger"
)

type album struct {
	ID     string  `json:"id"`
	Title  string  `json:"title"`
	Artist string  `json:"artist"`
	Price  float64 `json:"price"`
}

var albums = []album{
	{ID: "1", Title: "Blue Train", Artist: "John Coltrane", Price: 56.99},
	{ID: "2", Title: "Jeru", Artist: "Gerry Mulligan", Price: 17.99},
	{ID: "3", Title: "Sarah Vaughan and Clifford Brown", Artist: "Sarah Vaughan", Price: 39.99},
}

func main() {
	app := fiber.New(fiber.Config{
		Prefork:           true,
		AppName:           "Test App",
		EnablePrintRoutes: true,
	})

	log.SetLevel(log.LevelTrace)

	app.Use(logger.New(logger.Config{
		Format: "[${time}] ${status} - ${latency} - ${method}\n",
	}))

	app.Get("/albums", func(c *fiber.Ctx) error {
		return c.JSON(albums)
	})

	log.Fatal(app.Listen(":2343"))
}
