package main

import (
	"log"
	"net/http"
)

const port = "8081"

func main() {
	http.Handle("/", http.FileServer(http.Dir("./static")))

	log.Printf("VPN landing page listening on :%s\n", port)

	if err := http.ListenAndServe("10.99.0.1:"+port, nil); err != nil {
		log.Fatal(err)
	}
}
