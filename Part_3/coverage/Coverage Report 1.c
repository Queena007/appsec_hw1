Coverage Report 1
After running gcc --coverage on giftcardreader.c and executing several test cases, I discovered that approximately 46.6% of the code remained uncovered. This lack of coverage primarily stemmed from the "opcode" section particularly for operations associated with 0x02, 0x07, and 0x09 while overall coverage remain limited. I adjusted the type_of_record in the test from 1 to 3 while engaging with the animate function.

Coverage Report 2

I ifocbbused on enhancing coverage for the gift_card_json function, specifically targeting type 2 records. By executing cov_2.gft that includes a type 2 record, trigerring the relevant code path defined by the line else if (argv[1][0] == '2') gift_card_json(thisone)