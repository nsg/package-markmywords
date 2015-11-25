all: compile

package:
	docker build -t package-mmw .

compile: package out
	docker run \
		-v $$PWD/out:/home/build/MarkMyWords/out \
		-ti package-mmw

build:
	cd /home/build/MarkMyWords/out \
		&& cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=usr .. \
		&& make; make install

deb: build
	cd /home/build/MarkMyWords/out \
		&& fpm -s dir -t deb \
			-v 0 \
			--iteration $$(date +%s) \
			-n mark-my-words \
			--depends libwebkit2gtk-3.0-25 \
			$$(find usr/ -type f)

out:
	mkdir out

clean:
	rm -rf out
