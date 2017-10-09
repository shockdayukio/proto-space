# README

## User
### association
```
has_many: :prototypes, :likes, :comments
```
### table
- profile
- works
- image
- created_at
- updated_at

## Prototype
### association
```
has_many: :captureimages, :likes, :comments
belongs_to: :user
```
### table
- name
- catch_copy
- concept
- user_id
- created_at
- updated_at

## CapturedImage
### association
```
belongs_to: :prototype
```
### table
- image
- prototype_id

## Like
### association
```
belongs_to: :prototypes, :users
```
### table
- prototype_id
- user_id
- created_id
- updated_id

## Comment
### association
```
belongs_to: prototypes, :users
```
### table
- text
- prototype_id
- user_id
- created_id
- updated_id
