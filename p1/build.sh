#!/bin/sh

echo "Building Host Image..."
docker build -t aaudeber-host ./host
echo "Building Router Image..."
docker build -t aaudeber-router ./router
echo "Done! You can now import P1.gns3project safely."
