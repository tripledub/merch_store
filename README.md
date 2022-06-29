# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Current Ruby version `3.1.1`, Rails `~> 7.0.3`

- System dependencies

- Configuration

- Database creation

  - `bin/rails db:create`

- Database initialization

  - `bin/rails db:migrate`

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

## Testing with cURL

### List all items

```
curl -X GET \
  http://localhost:3000/api/v1/products \
  -H 'cache-control: no-cache'

# Sample response

[
    {
        "id": 1,
        "code": "MUG",
        "name": "Reedsy Mug",
        "price": 6,
        "created_at": "2022-06-29T16:23:29.137Z",
        "updated_at": "2022-06-29T16:23:29.137Z"
    },
    {
        "id": 2,
        "code": "TSHIRT",
        "name": "Reedsy T-Shirt",
        "price": 15,
        "created_at": "2022-06-29T16:23:29.144Z",
        "updated_at": "2022-06-29T16:23:29.144Z"
    },
    {
        "id": 3,
        "code": "HOODIE",
        "name": "Reedsy Hoodie",
        "price": 20,
        "created_at": "2022-06-29T16:23:29.148Z",
        "updated_at": "2022-06-29T16:23:29.148Z"
    }
]
```

### Update an items price

```
curl -X PUT \
  http://localhost:3000/api/v1/products/1 \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -d '{
	"product": {
		"price": "22.50"
	}
}'

# sample response
{
    "price": 22.5,
    "id": 1,
    "code": "MUG",
    "name": "Reedsy Mug",
    "created_at": "2022-06-29T16:23:29.137Z",
    "updated_at": "2022-06-29T18:03:38.241Z"
}
```

### Get the total price for a collection of items

```
curl -X POST \
  http://localhost:3000/api/v1/price_check \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -d '{
	"query": {
		"items": {
			"HOODIE": "1",
			"MUG": "20",
			"TSHIRT": "12"
		}
	}
}'
```
