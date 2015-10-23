title: CSS设置img水平属性
date: 2013-08-08 03:18:19
tags:
- CSS
categories:
- 笔记
---

wordpress官方处理图片水平居左、居右、居中的方法，简洁有效

	.alignleft {
		 display: inline;
		 float: left;
	}
	.alignright {
		 display: inline;
		 float: right;
	}
	.aligncenter {
		 clear: both;
		 display: block;
		 margin: auto;
	}