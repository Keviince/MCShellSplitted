package main

import (
	"biliDanMu/models"
	"fmt"
	"log"
	"os"
	"time"
	"flag"
)

func main() {
	var roomidint int
	flag.IntVar(&roomidint, "id", 2233, "房间号，默认为2233")
	flag.Parse()
	var roomid uint32 = uint32(roomidint)
	_ , err := fmt.Println(roomid)

	// 兼容房间号短 ID
	if roomid >= 100 && roomid < 1000 {
		roomid,err = models.GetRealRoomID(int(roomid))
		if err != nil {
			log.Println("房间号输入错误，请退出重新输入！")
			os.Exit(0)
		}
	}

	c, err := models.NewClient(roomid)
	if err != nil {
		fmt.Println("models.NewClient err: ", err)
		return
	}
	if err = c.Start(); err != nil {
		fmt.Println("c.Start err :", err)
		return
	}

	time.Sleep(time.Minute * 3)
}
