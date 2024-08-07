package models

type Flat struct {
	ID               uint   `json:"id"`
	CreatorID        uint   `json:"creatorID"`
	HouseID          uint   `json:"houseID"`
	Number           uint   `json:"number"`
	Price            uint   `json:"price"`
	RoomCount        uint   `json:"roomCount"`
	ModerationStatus string `json:"moderationStatus"`
}
