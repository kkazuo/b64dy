# Base64 subtext decoder CLI

Decode partially Base64-encoded strings.

## Usage

If you have this input.txt:

```yaml
apiVersion: v1
kind: Secret
data:
  DATABASE: bXlkYXRhYmFzZQ==
  HOST: bXlob3N0LnBvc3RncmVzLmRhdGFiYXNlLmV4YW1wbGUuY29t
  PASSWORD: dGhlc2VjcmV0
  PORT: NTQzMg==
  USER: bXl1c2Vy
```

    b64dy < input.txt

```yaml
apiVersion: v1
kind: Secret
data:
  DATABASE: mydatabase
  HOST: myhost.postgres.database.example.com
  PASSWORD: thesecret
  PORT: 5432
  USER: myuser
```

## Build

```sh
dart pub get
dart compile exe bin/b64dy.dart
```
