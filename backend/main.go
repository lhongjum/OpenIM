package main

import "backend/app"

func main() {
	if err := app.New(); err != nil {
		panic(err)
	}
}
