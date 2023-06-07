#!/usr/bin/env python
# coding: utf-8

# In[13]:


import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
get_ipython().run_line_magic('matplotlib', 'inline')
import plotly.express as px
sns.set_palette("rainbow")
sns.set_style("whitegrid")


# In[3]:


df=pd.read_csv("Bikestores")
df


# In[5]:


df.head()


# In[6]:


df.tail()


# In[8]:


df.shape


# In[7]:


df.info()


# In[9]:


df.isna().sum()


# In[11]:


sns.heatmap(df.isna())
plt.title("showing missing Data ")
plt.show()


# In[13]:


df.dropna(inplace=True)


# In[14]:


df.isna().sum()


# In[16]:


sns.heatmap(df.isna())
plt.title("without missing Data ")
plt.show()


# In[18]:


df.isnull().sum()


# In[20]:


df.notnull().sum()


# In[21]:


df.duplicated().sum()


# In[22]:


df.describe().round()


# In[24]:


df.columns


# In[26]:


corr=df.corr()
corr


# In[27]:


plt.matshow(corr)
plt.title("correlation between dataset ")
plt.show()


# In[30]:


df["state"].value_counts()


# In[31]:


df["product_name"].value_counts()


# In[32]:


df["category_name"].value_counts()


# In[33]:


df["store_name"].value_counts()


# In[17]:


df["brand_name"].value_counts()


# In[35]:


df["sales_rep"].value_counts()


# In[35]:


date=df[["order_date"]].sample(frac=1).head(7).reset_index(drop=True)
date


# In[45]:


date.info()


# In[40]:


df["order_date"]=pd.to_datetime(df["order_date"])
df["order_date"]


# In[41]:


df["order_date"].dt.year


# In[42]:


df["order_date"].dt.month


# In[49]:


df["year"]=df["order_date"].dt.year
df["month"]=df["order_date"].dt.month
df


# In[51]:


cd=df.groupby(["year"],as_index=False)["revenue"].sum().sort_values(by="revenue",ascending=False)
sns.barplot(data=cd,x="year",y="revenue")
plt.title(" Total Revenue ")
plt.show()


# In[13]:


cd=df.groupby(["sales_rep"],as_index=False)["revenue"].sum().sort_values(by="revenue",ascending=False)
sns.barplot(data=cd,x="revenue",y="sales_rep")
plt.title("Revenue by sales_rep")
plt.show()


# In[76]:


cd=df.groupby(["category_name"],as_index=False)["revenue"].sum().sort_values(by="revenue",ascending=False)

ax=sns.barplot(data=cd,x="revenue",y="category_name")
plt.title("Revenue by category_name")
plt.show()


# In[132]:


cd=df.groupby(["brand_name"],as_index=False)["revenue"].sum().sort_values(by="revenue",ascending=False)

ax=sns.barplot(data=cd,x="revenue",y="brand_name")
plt.title("Revenue by brand")
plt.show()


# In[17]:


cd=df.groupby(["customers"],as_index=False)["revenue"].sum().sort_values(by="revenue",ascending=False).head(10)

ax=sns.barplot(data=cd,x="revenue",y="customers")
plt.title("TOP TEN CUSTOMERS")
plt.show()


# In[130]:


fig=px.pie(df,names="store_name",values="revenue")
fig.update_traces(textinfo="percent+value")
fig.update_layout(title_text="revenue by store",title_x=0.5)
fig.show()


# In[152]:


fig=px.pie(df,names="state",values="revenue",hole=0.5)
fig.update_traces(textinfo="percent+value")
fig.update_layout(title_text="revenue by State",title_x=0.5)
fig.show()


# In[81]:


sns.lineplot(data=df,x="month",y="revenue",ci=None,estimator=sum,markers=True,hue="year",palette="pastel")
plt.title("Revenue per month")
plt.show()


# In[122]:


df["product_name"].value_counts().head(10).plot.pie()
plt.title("TOP TEN PRODUCTS")
plt.show()


# In[125]:


sns.kdeplot(data=df,x="revenue",multiple="stack",hue="year")
plt.title("Revenue per year ")
plt.show()


# In[129]:


sns.kdeplot(data=df,x="revenue",multiple="stack",hue="month")
plt.title("Revenue per Month ")
plt.show()


# In[135]:


sns.kdeplot(data=df,x="revenue",multiple="stack",hue="state")
plt.title("Revenue by State ")
plt.show()


# In[146]:


sns.kdeplot(data=df,x="revenue",multiple="stack",hue="store_name")
plt.title("Revenue by Store")
plt.show()


# In[141]:


sns.boxplot(x="state",y="revenue",data=df)
plt.title(" minimum and maximum Revenue in each state")
plt.show()


# In[142]:


sns.displot(df["revenue"],kde=True,bins=7)
plt.title("Distribution of revenue ")
plt.show()


# In[115]:


sns.countplot(x="state",data=df,hue="brand_name",palette="pastel")
plt.title("count of brands in each country")
plt.show()


# In[143]:


sns.countplot(x="store_name",data=df,hue="category_name",palette="pastel")
plt.title("count of category in each brand")
plt.show()


# In[121]:


sns.countplot(y="sales_rep",data=df,palette="pastel")
plt.title("count of sales_rep")
plt.show()

