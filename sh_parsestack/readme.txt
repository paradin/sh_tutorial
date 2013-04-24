stackwalker输出日志分析器

处理文件格式：
32

6D360269 (MSVCR100): (filename not available): malloc

32

6D360269 (MSVCR100): (filename not available): malloc



用法：
将栈文件改名成org.txt
执行 ./ana_parse.sh

生成文件：

raw2_unknow.txt  栈中路径不包含"\third_party\|\products\|\platform\"目录的栈
	包括：
		stlport
		Unknow stack


raw2_third.txt	栈中路径不包含"\products\|\platform\"目录, 包含"\third_party\"目录的栈
	包括：
		stackwarker                 
		xmllib\implementation\dom


raw2_products.txt 栈中路径包含在"\products\"目录下的栈
	包括：
		tui_window_frame.cpp
		client_frame        
		engine_wrapper 	    
		community	    
		::to_variant_ent    
		Template::CreateItem
		其他(guild,pet,item)
	
raw2_platform.txt 栈中路径不包含"\products\"目录, 包含"\platform\"目录的栈
	包括：
		client_ui	
		engine_wrapper  
		client_front    
		其他(pipe)      