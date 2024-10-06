default: all

# Compilation for all targets
all: giftcardreader.original giftcardreader.asan giftcardreader.ubsan giftcardreader.coverage

# Original build without sanitizers or coverage
giftcardreader.original: giftcardreader.c giftcard.h
	gcc -g -o $@ $<

# Build with AddressSanitizer
giftcardreader.asan: giftcardreader.c giftcard.h
	gcc -fsanitize=address -g -o $@ $<

# Build with UndefinedBehaviorSanitizer
giftcardreader.ubsan: giftcardreader.c giftcard.h
	gcc -fsanitize=undefined -g -o $@ $<

# Build with code coverage support
giftcardreader.coverage: giftcardreader.c giftcard.h
	gcc --coverage -g -o $@ $<

# Test target runs tests with ASAN and UBSAN
test: giftcardreader.original giftcardreader.asan giftcardreader.ubsan
	for f in testcases/valid/*.gft; do \
		./giftcardreader.asan 1 "$$f"; \
	done; \
	for f in testcases/invalid/*.gft; do \
		./giftcardreader.ubsan 1 "$$f"; \
	done

# Clean up the directory by removing the generated files
.PHONY: clean
clean:
	rm -f *.o giftcardreader.original giftcardreader.asan giftcardreader.ubsan giftcardreader.coverage *.gcda *.gcno *.info
