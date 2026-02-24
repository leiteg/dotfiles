import os
import sys
import atproto as at

if len(sys.argv) < 3:
    print(f"Error: not enough arguments provided, got {len(sys.argv)} expected 3.", file=sys.stderr)
    raise SystemExit(1)

username = "laranjadinho.deichator.ar"
if (password := os.environ.get("BLUESKY_PASSWORD")) is None:
    print("Error: bluesky password not set.", file=sys.stderr)
    raise SystemExit(2)

image = sys.argv[1]
message = sys.argv[2]

client = at.Client()
client.login(username, password)

with open(image, "rb") as f:
    data = f.read()
    response = client.send_image(text=message, image=data, image_alt="Lastfm Collage")
    print(response)
