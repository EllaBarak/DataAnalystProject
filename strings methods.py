#!/usr/bin/env python
# coding: utf-8

# String Methods

# ###String Methods

# ### string methods

# In[5]:


#len  מחזיר את גודל הסטרינג כולל רווחים
s= 'hi python'
len(s)


# In[6]:


# Upper
s.upper()


# In[7]:


s.lower()


# In[8]:


s.islower()


# In[9]:


s.lower()


# In[11]:


# כאן הפכנו לקטן ואז ישר שאלנו האם זה אותיות קטנות? אז נתן טרו כי זה נכון
s.lower(). islower()


# In[12]:


#method:
s.lower()


# In[13]:


#function:
len(s)


# In[15]:


s.capitalize()


# In[16]:


s.center(2)


# In[17]:


s.find('h')


# In[25]:


x= 'banana ,pitch, apple'


# In[28]:


# ספרטור זה מה לשים בין המילים- שינינו לפסיק כי הדיפולט זה רווח בין המילים
s.split(sep=',')


# In[29]:


type(x)


# In[30]:


s= '   banana   '


# In[34]:


# מוריד רווחים
s.strip()


# In[36]:


#מוריד רווחים משמאל
s.lstrip()


# In[38]:


#מוריד רווחים מימין
s.rstrip()


# In[42]:


s= ',,,,,,,GTGI,,,,,,'


# In[43]:


#מוריד את כל הפסיקים
s.strip(',')


# In[45]:


#מוריד ג'י מההתחלה ומהסוף וגם את הפסיקים
s=strip(',G')


# In[50]:


s= 'apple'


# In[51]:


#נותן טרו או פולס - אם מתחיל בAP
s.startwith('ap')


# In[56]:


#פעמיים סלש נותן  סלאש אחד
s= 'elad\\n'


# In[55]:


print (s)


# In[57]:


s='elad\'s'


# In[58]:


print(s)


# In[60]:


#אומר כמה פעמים אות מופיעה בסטרינג
s.count('e')


# In[62]:


#IN מחזיר האם האות קיימת או לא קיימת במילה
print('e' in s)


# In[64]:


#כדי לראות את כל המטודות של אובייקט מסויים- כאן זה כל המטודות של סטרינג
dir(s)


# In[65]:


#איך מדפיסים אובייקטים משתנים:

a=3
b=5

print ('{} + {} = {}' .format(a,b, a+b))


# In[67]:


# כמו למעלה. ונדע כי אפ וגרש זה קיצור של פורמט
print(f'{a} + {b} = {a+b}')


# In[69]:


#לראות מטודות של NUM

num=5


# In[70]:


dir(num)


# In[ ]:




