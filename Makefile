
default: all


all: giftcardreader.original giftcardreader.asan giftcardreader.ubsan


giftcardreader.original: giftcardreader.c giftcard.h
	gcc -g -o $@ $<


giftcardreader.asan: giftcardreader.c giftcard.h
	gcc -fsanitize=address -g -o $@ $<


giftcardreader.ubsan: giftcardreader.c giftcard.h
	gcc -fsanitize=undefined -g -o $@ $<

test: giftcardreader.original giftcardreader.asan giftcardreader.ubsan
	./runtests.sh

.PHONY: clean
clean:
	rm -f *.o giftcardreader.original giftcardreader.asan giftcardreader.ubsan


test:
    ./giftcardreader.asan testcases/valid/* 
    ./giftcardreader.ubsan testcases/invalid/*
