load:
	while true; do \
		curl --silent --output /dev/null http://localhost:8090/tea/sencha?size=small; \
		sleep 0.5; \
		curl --silent --output /dev/null http://localhost:8090/tea/english%20breakfast?size=small; \
		sleep 0.5; \
	done \

chaos:
	docker exec toxiproxy /toxiproxy-cli toxic add --toxicName base-latency --type latency --downstream --toxicity 1.0 --attribute latency=50 --attribute jitter=0 water-db
	# in order to make tail-latency work, you need to disable the DB connection pool (HikariCP)
	# since ToxiProxy injects latency on the connection (TCP) level
	# and a new connection is needed to inject latency for less than 100% or the connections
	#docker exec toxiproxy /toxiproxy-cli toxic add --toxicName tail-latency --type latency --downstream --toxicity 0.005 --attribute latency=150 --attribute jitter=0 water-db
