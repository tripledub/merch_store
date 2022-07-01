# About me

Living in Mallorca, Spain I like to take full advantage of the opportunities to be outdoors. I enjoy a host of activities including road cycling, running, hiking and swimming in the ocean. When I'm not outdoors, I like to read, mainly technical and non-fiction titles. I've worked professionally with Internet technologies for over twenty years, specialising mainly in back-end development for the past fifteen. In this time, I've risen to the position of Lead Developer with my current employer, Hexopay.

I'm extremely proud of the team I've built and what we have achieved with such a small team. One really great feature we delivered with myself as lead was a hosted fields feature that allows merchants to have full control over branding and form layout without having to have cardholder data pass through their systems, making them liable for PCI standards compliance. Previously, I played a major part in the team that delivered ‘Brands into Warehouse’ at Silk Fred. This lead to an instant impact on profitability and customer satisfaction by streamlining the optimizing the distribution and returns process when products are sourced from multiple warehouses.

# README

- Current Ruby version `3.1.1`, Rails `~> 7.0.3`

- System dependencies

  - Run `bundle install`

- Database creation

  - `bin/rails db:create`

- Database initialization

  - `bin/rails db:migrate`

  If you want to test the API with cURL or Postman etc, there are some seeds populate the database and get you started

  - `bin/rails db:seed`

- How to run the test suite

  - `bin/rspec spec`

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
