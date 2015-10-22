title: my-php-ftp
date: 2013-07-12 00:33:19
tags:
- PHP
categories:
- 笔记
---

想写一个类似ftp具有目录浏览和文件下载功能简单的目录浏览器，起因是架设ftp用户访问没有用浏览器直接打开快捷，而apache和Nginx的目录浏览功能打开后，页面太丑，不太友好，apache文件名稍微一长，文件名就显示不完整，而Nginx字体太小，界面也不太友好，想到PHP的文件操作函数，何不自己用PHP写一个呢？

开始动手写PHP，大致思路就是接受用户指定的目录参数，利用PHP目录浏览函数遍历该目录并输出该目录中的文件夹和文件，并拼凑出文件夹和文件的URL访问地址作为链接，达到递归浏览目录和文件下载功能。

设计了前台界面的表格显示样式，效果如下：

![my-php-ftp](/uploads/images/my-php-ftp.png "my-php-ftp显示效果")

比起nginx目录浏览界面还是友好的，对于jpeg、png、bmp等图片格式，利用thickbox插件让用户能够直接在浏览器中点击浏览图片，如果喜欢可下载至本地。利用jQuery对table的tr添加了hover属性，让选择的行突出显示，页脚添加了php执行时间。

似乎到此为止一切工作都能结束了，自己测试也很正常，但觉得似乎文件一多，用户查找文件就比较麻烦，想到了为表格添加排序功能。

网上有很多关于表格排序的jQuery项目，如datatable，tablesorter等，功能都很强大，调用也比较方便，但毕竟那是别人写的，还是想自己写一个，就像那句话：

***喜欢自己做蛋糕吃！***

自从物联网项目结束后，自己有一段时间没写过js代码了，来练练手吧。

其实还是蛮简单的，大致流程就是为想排序的table的thead的th添加click事件，利用index函数获得排序的列的序号，用选择器获得所有需要排序的行，利用sort函数，定义序号对应的td标签文本作为关键字排序，对排序完后的tr行append到tbody中,重新调整一下表格显示。说起来很简单，做起来还是会遇到很多意想不到的错误的，比如排序，要分数字和字符串比较，自己最开始就忽视了，导致测试时排序结果和预想不符。自己记录下了排序的运行时间，在页脚显示出来，方便查看排序效率。

js表格排序主要代码：

	function adjust(mytable){
		$(mytable+' tbody tr').each( function(key,value){
		    if((key+1)%2==1) $(this).addClass('odd');
		    else  $(this).addClass('even');
	    });
	}
	function myphpftp(mytable){
		adjust(mytable);
	    $(mytable+" tbody  tr").hover(
	    	function(){$(this).children("td").addClass("gray");},
	    	function(){$(this).children("td").removeClass("gray");}
		);
		$(mytable+" thead tr").children("th").addClass("headerSort");
		$(mytable+' thead tr th').click(function(){ 
			var date1=(new Date()).getTime();
			var index=$(mytable+' thead tr th').index(this)+1;
			var rows=$(mytable+' tbody tr');
			
	        if($(this).hasClass('headerSortUp')){ //逆序排序
				rows.sort(function(a,b){
		  			var aText=$(a).find('td:nth-child('+index+')').text().toUpperCase(); 
					var bText=$(b).find('td:nth-child('+index+')').text().toUpperCase();
					if(index==2){
						aText=Parse(aText); bText=Parse(bText);
					}
					return aText>bText?-1:bText>aText?1:0; 
				});
				$(this).removeClass('headerSortUp');
				$(this).addClass('headerSortDown');
			}else { //顺序排序
				rows.sort(function(a,b){
		  			var aText=$(a).find('td:nth-child('+index+')').text().toUpperCase(); 
					var bText=$(b).find('td:nth-child('+index+')').text().toUpperCase();
					if(index==2){ 
						aText=Parse(aText); bText=Parse(bText);
					}
					return aText>bText?1:bText>aText?-1:0; 
				});
				$('.headerSortUp,.headerSortDown').addClass('headerSort'); 
				$('.headerSortUp').removeClass('headerSortUp');
				$('.headerSortDown').removeClass('headerSortDown');
				$(this).addClass('headerSortUp'); 
			} 
			$.each(rows,function(index,row){
				$(mytable+' tbody').append(row);
	     	})
	     	$(mytable+' tbody .odd').removeClass('odd');
	     	$(mytable+' tbody .even').removeClass('even');
	     	adjust(mytable);
			var run_time=(new Date()).getTime()-date1; 
			$('#run_time').html( (run_time/1000.0).toFixed(4) ); 
		})
	}
	function Parse(data){
		return parseFloat(data)||0; 
	}

这个初级版本功能还比较简单，自己以后慢慢更新添加新功能吧，如用户认证，大文件上传，优化效率之类的。