PROJECT=b64dy

exe:
	@docker run --rm \
	-v "$$PWD/bin:/root/bin" \
	-v "$$PWD/build:/root/build" \
	-v "$$PWD/pubspec.yaml:/root/pubspec.yaml" \
	dart:stable \
	sh -c "dart pub get && dart compile exe -o build/$(PROJECT) bin/$(PROJECT).dart"
