# Base description

ruby 2.3.1
rails 5.2

# Extra Gems
redis, hiredis are used for caching, as I think it's the most reasonable choice

contentful is used for sending http requests

haml is used for html preprocessing, I just like it

kaminari is used for pagination
markdown-rails is used for markdown (just first gem i found)

# Run application

1. set CONTENTFUL_SPACE_ID and CONTENTFUL_ACCESS_TOKEN in docker-compose.yml
2. docker-compose build
3. export UID && docker-compose up

# Page speed up

As I can see there are two ways to minimize number of http request
1. Request as much as possible, for example request content with prebuild asosiations
2. Cache api responses somehow, I chose rails object caching with redis backend