# Protospace
## Environment
- Ruby version: 2.4.0
- Rails version: 5.0.0

## Tables and their associations
### User
#### association
```
has_many: :prototypes, :likes, :comments
```
#### table

- profile
- works
- avatar
- created_at
- updated_at

### Prototype
#### association
```
has_many: :captured_images, :likes, :comments
belongs_to: :user
```
#### table
- name
- catch_copy
- concept
- user_id
- created_at
- updated_at

### CapturedImage
#### association
```
belongs_to: :prototype
```
#### table
- image
- status
- prototype_id

### Like
#### association
```
belongs_to: :prototypes, :users
```
#### table
- prototype_id
- user_id
- created_at
- updated_at

### Comment
#### association
```
belongs_to: prototypes, :users
```
#### table
- text
- prototype_id
- user_id
- created_id
- updated_id
