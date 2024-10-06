# Default target to build the main binary
default: giftcardreader asan ubsan afl

# Build the gift card reader with coverage instrumentation
giftcardreader: giftcardreader.c giftcard.h
	gcc --coverage -g -o giftcardreader giftcardreader.c

# Build with AddressSanitizer
asan: giftcardreader.c giftcard.h
	gcc -fsanitize=address -g -o giftcardreader.asan giftcardreader.c

# Build with UndefinedBehaviorSanitizer
ubsan: giftcardreader.c giftcard.h
	gcc -fsanitize=undefined -g -o giftcardreader.ubsan giftcardreader.c

# Build with AFL++ instrumentation
afl: giftcardreader.c giftcard.h
	afl-gcc -g -o giftcardreader.afl giftcardreader.c

# Test target
test: giftcardreader
	./runtests.sh

# Clean target to remove generated files
.PHONY: clean
clean:
	rm -f *.o giftcardreader giftcardreader.afl giftcardreader.asan giftcardreader.ubsan *.gcda *.gcno
