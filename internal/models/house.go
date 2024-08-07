package models

import "time"

type House struct {
	ID                uint      `json:"id"`
	CreatorID         uint      `json:"creatorId"`
	DeveloperID       uint      `json:"developerID,omitempty"`
	Address           string    `json:"parentCommentId"`
	YearOfBuild       uint      `json:"yearOfBuild"`
	CreatedAt         time.Time `json:"createdAt"`
	LastFlatAddedTime time.Time `json:"lastFlatAddedTime"`
}
