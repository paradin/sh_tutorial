#!/bin/bash

SRC_FILTE_FILE=raw2_filte.txt
DES_UNKNOW_FILE=raw2_unknow.txt


echo "Analyse..."
echo
echo "Unknown memory use: "
cat $SRC_FILTE_FILE | grep -v -E '\\products\\|\\platform\\|\\third_party\\' | awk -F'\t' '{ sum+=$1; }  END { print sum; }'
echo "Detail see file: " $DES_UNKNOW_FILE
cat $SRC_FILTE_FILE | grep -v -E '\\products\\|\\platform\\|\\third_party\\' | sed 's/@/\n/g' > $DES_UNKNOW_FILE

DES_THIRD_FILE=raw2_third.txt
echo
echo "third_party memory use: "
cat $SRC_FILTE_FILE | grep -E '\\products\\|\\platform\\|\\third_party\\' | grep -v -E '\\products\\|\\platform\\' | grep '\\third_party\\'  | awk -F'\t' '{ sum+=$1; }  END { print sum; }'
echo "Detail see file: " $DES_THIRD_FILE
cat $SRC_FILTE_FILE | grep -E '\\products\\|\\platform\\|\\third_party\\' | grep -v -E '\\products\\|\\platform\\' | grep '\\third_party\\'  | sed 's/@/\n/g' > $DES_THIRD_FILE

DES_PRODUCTS_FILE=raw2_products.txt
echo
echo "products memory use: "
cat $SRC_FILTE_FILE | grep -E '\\products\\|\\platform\\|\\third_party\\' | grep '\\products\\'  | awk -F'\t' '{ sum+=$1; }  END { print sum; }'
echo "Detail see file: " $DES_PRODUCTS_FILE
cat $SRC_FILTE_FILE | grep -E '\\products\\|\\platform\\|\\third_party\\' | grep '\\products\\'  | sed 's/@/\n/g' > $DES_PRODUCTS_FILE

DES_PLATFORM_FILE=raw2_platform.txt
echo
echo "platform memory use: "
cat $SRC_FILTE_FILE | grep -E '\\products\\|\\platform\\|\\third_party\\' | grep -v -E '\\products\\' | grep '\\platform\\'  | awk -F'\t' '{ sum+=$1; }  END { print sum; }'
echo "Detail see file: " $DES_PLATFORM_FILE
cat $SRC_FILTE_FILE | grep -E '\\products\\|\\platform\\|\\third_party\\' | grep -v -E '\\products\\' | grep '\\platform\\'  | sed 's/@/\n/g' > $DES_PLATFORM_FILE

echo
echo 'raw2_unknow.txt  Exclude in stack with (third_party,products,platform) directory'
cat $SRC_FILTE_FILE | grep -v -E '\\products\\|\\platform\\|\\third_party\\' | awk -F'\t' '{ sum+=$1; }  END { print sum; }'
echo "	include:"
echo "		stlport"
cat $SRC_FILTE_FILE | grep -v -E '\\products\\|\\platform\\|\\third_party\\' | grep -E '\\stlport\\' | awk -F'\t' ' BEGIN {sum=0;} { sum+=$1; }  END { print sum; }'
echo "		Unknown stack "
cat $SRC_FILTE_FILE | grep -v -E '\\products\\|\\platform\\|\\third_party\\' | grep -v -E '\\stlport\\' | awk -F'\t' ' BEGIN {sum=0;} { sum+=$1; }  END { print sum; }'

echo
echo 'raw2_third.txt	Exclude in stack with (products,platform) directory, include (third_party) directory'
cat $SRC_FILTE_FILE | grep -E '\\products\\|\\platform\\|\\third_party\\' | grep -v -E '\\products\\|\\platform\\' | grep '\\third_party\\'  | awk -F'\t' '{ sum+=$1; }  END { print sum; }'
echo "	include:"
echo "		stackwalker"
cat $SRC_FILTE_FILE | grep -E '\\products\\|\\platform\\|\\third_party\\' | grep -v -E '\\products\\|\\platform\\' | grep '\\third_party\\' | grep -E '\\stackwalker\\' | awk -F'\t' ' BEGIN {sum=0;} { sum+=$1; }  END { print sum; }'
echo "		h3dxmllib\implementation\dom"
cat $SRC_FILTE_FILE | grep -E '\\products\\|\\platform\\|\\third_party\\' | grep -v -E '\\products\\|\\platform\\' | grep '\\third_party\\' | grep -E '\\h3dxmllib\\' | awk -F'\t' ' BEGIN {sum=0;} { sum+=$1; }  END { print sum; }'
echo "		Others"
cat $SRC_FILTE_FILE | grep -E '\\products\\|\\platform\\|\\third_party\\' | grep -v -E '\\products\\|\\platform\\' | grep '\\third_party\\' | grep -v -E '\\stackwalker\\|\\h3dxmllib\\' | awk -F'\t' ' BEGIN {sum=0;} { sum+=$1; }  END { print sum; }'

echo
echo 'raw2_products.txt Include in stack with (products) directory '
cat $SRC_FILTE_FILE | grep -E '\\products\\|\\platform\\|\\third_party\\' | grep '\\products\\'  | awk -F'\t' '{ sum+=$1; }  END { print sum; }'
echo "	include:"
echo "		tui_window_frame.cpp"
cat $SRC_FILTE_FILE | grep -E '\\products\\|\\platform\\|\\third_party\\' | grep '\\products\\'  | grep 'tui_window_frame\.cpp' | awk -F'\t' ' BEGIN {sum=0;} { sum+=$1; }  END { print sum; }'
echo "		client_frame"
cat $SRC_FILTE_FILE | grep -E '\\products\\|\\platform\\|\\third_party\\' | grep '\\products\\'  | grep -v 'tui_window_frame\.cpp' | grep '\\client_frame\\' | awk -F'\t' ' BEGIN {sum=0;} { sum+=$1; }  END { print sum; }'
echo "		tui_ani.cpp" 
cat $SRC_FILTE_FILE | grep -E '\\products\\|\\platform\\|\\third_party\\' | grep '\\products\\'  | grep -v 'tui_window_frame\.cpp' | grep 'tui_ani\.cpp' | awk -F'\t' ' BEGIN {sum=0;} { sum+=$1; }  END { print sum; }'
echo "		engine_wrapper"	
cat $SRC_FILTE_FILE | grep -E '\\products\\|\\platform\\|\\third_party\\' | grep '\\products\\'  | grep -v 'tui_window_frame\.cpp' | grep -v '\\client_frame\\' | grep '\\engine_wrapper\\' | awk -F'\t' ' BEGIN {sum=0;} { sum+=$1; }  END { print sum; }'
echo "		community" 
cat $SRC_FILTE_FILE | grep -E '\\products\\|\\platform\\|\\third_party\\' | grep '\\products\\'  | grep -v 'tui_window_frame\.cpp' | grep -v '\\client_frame\\' | grep -v '\\engine_wrapper\\' | grep '\\community\\' | awk -F'\t' ' BEGIN {sum=0;} { sum+=$1; }  END { print sum; }'
echo "		::to_variant_ent"
cat $SRC_FILTE_FILE | grep -E '\\products\\|\\platform\\|\\third_party\\' | grep '\\products\\'  | grep -v 'tui_window_frame\.cpp' | grep -v '\\client_frame\\' | grep -v '\\engine_wrapper\\' | grep -v '\\community\\' | grep '::to_variant_ent' | awk -F'\t' ' BEGIN {sum=0;} { sum+=$1; }  END { print sum; }'
echo "		Others" 
cat $SRC_FILTE_FILE | grep -E '\\products\\|\\platform\\|\\third_party\\' | grep '\\products\\'  | grep -v 'tui_window_frame\.cpp' | grep -v '\\client_frame\\' | grep -v '\\engine_wrapper\\' | grep -v '\\community\\' | grep -v '::to_variant_ent' | grep -v 'Template::CreateItem' | awk -F'\t' ' BEGIN {sum=0;} { sum+=$1; }  END { print sum; }'

echo 
echo 'raw2_platform.txt Exclude in stack with (products) directory, include (platform) directory'
cat $SRC_FILTE_FILE | grep -E '\\products\\|\\platform\\|\\third_party\\' | grep -v -E '\\products\\' | grep '\\platform\\'  | awk -F'\t' '{ sum+=$1; }  END { print sum; }'
echo "	include:"
echo "		client_ui"
cat $SRC_FILTE_FILE | grep -E '\\products\\|\\platform\\|\\third_party\\' | grep -v '\\products\\'  | grep '\\platform\\' | grep '\\client_ui\\' | awk -F'\t' ' BEGIN {sum=0;} { sum+=$1; }  END { print sum; }'
echo "		engine_wrapper"
cat $SRC_FILTE_FILE | grep -E '\\products\\|\\platform\\|\\third_party\\' | grep -v '\\products\\'  | grep '\\platform\\' | grep -v '\\client_ui\\' | grep '\\engine_wrapper\\' | awk -F'\t' ' BEGIN {sum=0;} { sum+=$1; }  END { print sum; }'
echo "		client_front"
cat $SRC_FILTE_FILE | grep -E '\\products\\|\\platform\\|\\third_party\\' | grep -v '\\products\\'  | grep '\\platform\\' | grep -v '\\client_ui\\' | grep -v '\\engine_wrapper\\' | grep 'client_front' | awk -F'\t' ' BEGIN {sum=0;} { sum+=$1; }  END { print sum; }'
echo "		Others(pipe)"
cat $SRC_FILTE_FILE | grep -E '\\products\\|\\platform\\|\\third_party\\' | grep -v '\\products\\'  | grep '\\platform\\' | grep -v '\\client_ui\\' | grep -v '\\engine_wrapper\\' | grep -v 'client_front' | awk -F'\t' ' BEGIN {sum=0;} { sum+=$1; }  END { print sum; }'

