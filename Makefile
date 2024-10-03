default: all

all: giftcardreader.original giftcardreader.asan giftcardreader.ubsan

giftcardreader.original: giftcardreader.c giftcard.h
	gcc -g -o $@ $<

giftcardreader.asan: giftcardreader.c giftcard.h
	gcc -fsanitize=address -g -o $@ $<

giftcardreader.ubsan: giftcardreader.c giftcard.h
	gcc -fsanitize=undefined -g -o $@ $<

test: giftcardreader.original giftcardreader.asan giftcardreader.ubsan
	for f in testcases/valid/*.gft; do \
		./giftcardreader.asan 1 "$$f"; \
	done; \
	for f in testcases/invalid/*.gft; do \
		./giftcardreader.ubsan 1 "$$f"; \
	done

.PHONY: clean
clean:
	rm -f *.o giftcardreader.original giftcardreader.asan giftcardreader.ubsan