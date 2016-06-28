# -*- coding: UTF-8 -*-
from YSGApp import views
from django.conf.urls import patterns, include, url

from django.contrib import admin
admin.autodiscover()

urlpatterns = [
    url(r'^admin/', include(admin.site.urls)),
    url(r'^user/login/', views.user_login),
    url(r'^user/register/', views.user_register),
    url(r'^user/logout/', views.user_logout),
    url(r'^news/list/', views.promotion_list),
    url(r'^promotion/list/', views.promotion_list),
    url(r'^promotion/detail/', views.promotion_detail),
    url(r'^search/promotion/', views.search_promotion),
    url(r'^search/home/', views.search_home),
    url(r'^favorite/book/', views.get_favourite),
    url(r'', views.get_all_user),
]

'''
http://localhost:8000/user/register/?school=uestc&name=shuaihan&studentNo=201421010517&passwd=admin&gender=1&phone=15682017891&email=466629332%40qq.com
http://localhost:8000/user/login/?passwd=admin&name=shuaihan
https://api.douban.com/v2/book/isbn/:9787020042494
'''