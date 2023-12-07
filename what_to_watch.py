#!/usr/bin/env python
# coding: utf-8

# ## **IMDB Dataset : Top 1000 Movies**

# #### **Columns & Descriptions**
# * Poster_Link = Link of the poster that imdb using
# * Series_Title = Name of the movie
# * Released_Year = Year in which movie released
# * Certificate = Certificate earned by that movie
# * Runtime = Total runtime of the movie
# * Genre = Genre of the movie
# * IMDB_Rating 
# * Overview = Description
# * Meta_score = Score earned by the movie
# * Director = Name of the Director
# * Star1,Star2,Star3,Star4 = Name of the Actors
# * No_of_votes = Total number of votes on IMDB
# * Gross = Total gross revenue earned

# # Cleaning the Data

# In[310]:


import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import sklearn

from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.decomposition import PCA
from sklearn.metrics.pairwise import cosine_similarity
from sklearn.feature_extraction.text import TfidfVectorizer


# In[311]:


path = "C:/Users/sdsouza/Downloads/what_to_watch.csv"
df = pd.read_csv(path)
df.head()


# In[312]:


df.info()


# **Clean Up Columns**

# In[313]:


# Check the column names
print(df.columns)

# Add actors in one column and drop others
star_columns = ['Star1', 'Star2', 'Star3', 'Star4']
if all(col in df.columns for col in star_columns):
    df['Stars'] = df[star_columns].astype(str).agg(', '.join, axis=1)
    df.drop(star_columns, axis=1, inplace=True)
else:
    print("Some stars don't appear in the DataFrame.")

df.head()


# In[314]:


# Handle missing or non-finite values in 'Released_Year'
#df['Released_Year'] = df['Released_Year'].fillna(0).astype(int)
#df.head()


# In[315]:


df['Released_Year'] = (df['Released_Year'].str.replace('PG','0')).astype(int)


# In[316]:


# Extract only numeric values from 'Runtime'
df['Runtime'] = df['Runtime'].str.extract('(\d+)', expand=False).astype(float)


# In[317]:


# Handle missing or non-finite values in 'Gross'
df['Gross'] = df['Gross'].str.replace(',', '').astype(float)

df.head()


# In[318]:


# Save the Cleaned DataFrame to a CSV file
df.to_csv('final_data_v1.csv', index=False)


# #### Create a Modified Rating as a combination of IMDB Ratings & No. of Votes**

# In[319]:


# create modified rating
normalize_No_of_Votes = (df['No_of_Votes']-df['No_of_Votes'].min()) / (df['No_of_Votes'].max()-df['No_of_Votes'].min())
df['Modified_Rating'] =  normalize_No_of_Votes + df['IMDB_Rating']

# get ordered columns
df = df[['Series_Title', 'Released_Year', 'Genre', 'Runtime', 'Overview', 'Stars', 'Director', 'IMDB_Rating', 'Modified_Rating', 'Meta_score', 'Gross']]
df.head()


# # Recommendation System 

# ### Text Based Filtering Recommender System

# We try to use ['Genre', 'Overview', 'Stars', 'Director'] as inputs to recommend what movies are similar to the selected movie 

# In[320]:


content = (df['Series_Title'].str.cat(df[['Overview', "Stars", "Director", "Genre"]], sep=" ")).to_list()
recom_df = pd.DataFrame(content, columns=["Content"], index = df.Series_Title)
print('#'*29)
print('Example for conent of Movies: ')
print('#'*29, '\n')
print(recom_df["Content"][1])


# In[321]:


recom_df.head()


# In[322]:


# Replace NaN values in the 'Content' column with an empty string
recom_df['Content'] = recom_df['Content'].fillna('')


# **Using TF-IDF (Term Frequency * Inverse Document Frequency) to give importance to words**
# 
# * Term Frequency = frequncy of word in a document
# * Inverse Document Frequency = log of all number of document in corpus(N) divided by number of document that word appears(nt)
# 
# **EX:// we have two documents** 
# 
# **['I am Shilpa', 'I am working at Ting']**
# * Unique words [i, am, shilpa, working, at, ting]
# * I/am = 2(TF) * log(2/2)(IDF) = 2*0 = 0
# * Shilpa/Ting = 1(TF) * log(2/1)(IDF) = 1*0.3 = 0.3
# 
# **This means 'Shilpa'/'Ting' words more important than 'I'/'am' words**

# **Define a TF-IDF Vectorizer**

# In[323]:


#Define a TF-IDF Vectorizer Object. Remove all english stop words such as 'the', 'a'
tfidf = TfidfVectorizer(stop_words='english',max_df=0.8, min_df=0.002) ##constrained the columns

#Construct the required TF-IDF matrix by fitting and transforming the data
tfidf_matrix = tfidf.fit_transform(recom_df['Content'])

#Output the shape of tfidf_matrix
tfidf_matrix.shape


# In[324]:


# Convert the TF-IDF matrix to a Pandas DataFrame
tfidf_df = pd.DataFrame(tfidf_matrix.toarray(), columns=tfidf.get_feature_names())


# In[325]:


# Check the vocabulary size
print(len(tfidf.get_feature_names()))


# In[326]:


# Label the index column
tfidf_df = tfidf_df.rename_axis("Index")


# In[327]:


tfidf_df.head()


# In[328]:


# Save the TF-IDF DataFrame as a CSV file
tfidf_df.to_csv('tfidf_matrix.csv', index=False)


# **Compute the cosine similarity**

# **Computing the cosine similarity to get similarity ratio among movies with the dot product of two vectors**
# 
# **a.b = |a||b|cosθ**

# In[329]:


# Compute the cosine similarity matrix
cosine_sim = cosine_similarity(tfidf_matrix, tfidf_matrix)
cos_df = pd.DataFrame(cosine_sim, columns=df.Series_Title)
cos_df['Series_Title'] = df.Series_Title
cos_df = cos_df[['Series_Title'] + cos_df.columns[:-1].to_list()]
cos_df.head()


# In[330]:


# Create a DataFrame with the cosine similarity matrix
cos_df = pd.DataFrame(cosine_sim, columns=df.Series_Title)
cos_df['Series_Title'] = df.Series_Title
cos_df = cos_df[['Series_Title'] + cos_df.columns[:-1].to_list()]

# Save the DataFrame as a CSV file
cos_df.to_csv('cosine_similarity_matrix.csv', index=False)


# In[331]:


#Construct a reverse map of indices and movie titles
idxs = pd.Series(df.index, index=df.Series_Title)

# Construct a DataFrame from the reverse map
reverse_map_df = pd.DataFrame({'Series_Title': idxs.index, 'Index': idxs.values})

# Save the DataFrame as a CSV file
reverse_map_df.to_csv('idxs.csv', index=False)


# In[332]:


reverse_map_df.head()


# In[333]:



   # Get the index of the movie that matches the title
   idx = idxs[title]

   # Get the pairwsie similarity scores of all movies with that movie
   sim_scores = list(enumerate(cosine_sim[idx]))
   
   # Sort the movies based on the similarity scores
   sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)

   # Get the scores of the 10 most similar movies
   sim_scores = sim_scores[:11]
   
   sim_scores


# **Since Looker Join was becoming too complex, we did the movie similarity in Python itself and uploaded the table to BQ by redoing above steps and saving**
# 

# In[334]:


import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

# Combine relevant columns into a single 'Content' column
content = (df['Series_Title'].str.cat(df[['Overview', 'Stars', 'Director', 'Genre']], sep=" ")).to_list()

# Create a DataFrame with the combined content
recom_df = pd.DataFrame(content, columns=["Content"], index=df.Series_Title)

# Replace NaN values in the 'Content' column with an empty string
recom_df['Content'] = recom_df['Content'].fillna('')

# Define a TF-IDF Vectorizer Object
tfidf = TfidfVectorizer(stop_words='english', max_df=0.8, min_df=0.002)

# Construct the required TF-IDF matrix by fitting and transforming the data
tfidf_matrix = tfidf.fit_transform(recom_df['Content'])

# Compute the cosine similarity matrix
cosine_sim = cosine_similarity(tfidf_matrix, tfidf_matrix)

# Create a DataFrame with the cosine similarity matrix
cos_df = pd.DataFrame(cosine_sim, columns=df.Series_Title)
cos_df['Series_Title'] = df.Series_Title
cos_df = cos_df[['Series_Title'] + cos_df.columns[:-1].to_list()]

# Create a list to store the data for the "movie_similarity" table
movie_similarity_data = []

# Iterate through each movie and its similarity scores
for title in df['Series_Title']:
    # Get the index of the movie that matches the title
    idx = cos_df.index[cos_df['Series_Title'] == title].tolist()[0]
    
    # Get the pairwise similarity scores of all movies with that movie
    sim_scores = list(enumerate(cosine_sim[idx]))
    
    # Sort the movies based on the similarity scores
    sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)
    
    # Get the scores of the 10 most similar movies
    sim_scores = sim_scores[:11]
    
    # Extract the movie titles and cosine similarities
    movie_titles = [cos_df['Series_Title'][i] for i, _ in sim_scores[1:]]
    similarities = [score for _, score in sim_scores[1:]]
    
    # Append the data to the list
    movie_similarity_data.extend(list(zip([title] * 10, movie_titles, similarities)))

# Create the "movie_similarity" DataFrame
movie_similarity = pd.DataFrame(movie_similarity_data, columns=["movie_id_1", "movie_id_2", "cosine_similarity"])

# Save the DataFrame as a CSV file
movie_similarity.to_csv('movie_similarity.csv', index=False)


# # TEST

# 
# **Create get_recommendations Function**

# In[272]:


#Construct a reverse map of indices and movie titles
idxs = pd.Series(df.index, index=df.Series_Title)

# Function that takes in movie title as input and outputs most similar movies
def get_recommendations(title):
    # Get the index of the movie that matches the title
    idx = idxs[title]

    # Get the pairwsie similarity scores of all movies with that movie
    sim_scores = list(enumerate(cosine_sim[idx]))

    # Sort the movies based on the similarity scores
    sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)

    # Get the scores of the 10 most similar movies
    sim_scores = sim_scores[:11]

    # Get the movie indices
    movie_indices = [i[0] for i in sim_scores]

    # Return the top 10 most similar movies
    return df.iloc[movie_indices]


# In[336]:


movie = 'Casino Royale' # 'Write Your Favourate Movie here '
get_recommendations(movie)

