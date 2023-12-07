view: movie_recommendations {
    derived_table: {
      sql:
              -- Write your SQL logic to compute movie recommendations
              -- This SQL will vary depending on your database structure

        SELECT
        idxs.series_title as movie_title,
        ARRAY_AGG(STRUCT(cosine_sim.series_title, cosine_sim.similarity_score)) as similar_movies
        FROM
        precise-plane-407222.imdb_dataset.tdfidf_matrix idxs
        JOIN
        precise-plane-407222.imdb_dataset.cosine_similarity cosine_sim ON idxs.series_title = cosine_sim.series_title
        GROUP BY
        idxs.title;;

        # persist_for: "24 hours";  -- This is optional, adjust based on your data update frequency
        }

        dimension: movie_title {
        primary_key: yes
        type: string
        sql: ${TABLE}.movie_title ;;
        }

        # dimension: similar_movies {
        # type: array
        # hidden: yes
        # }

        measure: similarity_score {
        type: number
        hidden: yes
        sql: ${TABLE}.similarity_score ;;
    }

    measure: top_10_similar_movies {
      type: number
      sql: ${similarity_score} ;;
      value_format_name: "decimal_2"
    }

  }

# iew: movie_recommendations {
#   derived_table: {
#     sql: |
#       -- Write your SQL logic to compute movie recommendations
#       -- This SQL will vary depending on your database structure

#       SELECT
#       idxs.title as movie_title,
#       ARRAY_AGG(STRUCT(cosine_sim.movie_title, cosine_sim.similarity_score)) as similar_movies
#       FROM
#       idxs
#       JOIN
#       cosine_sim ON idxs.idx = cosine_sim.idx
#       GROUP BY
#       idxs.title;

#       persist_for: "24 hours";  -- This is optional, adjust based on your data update frequency
#       }

#       dimension: movie_title {
#       primary_key: yes
#       type: string
#       }

#       dimension: similar_movies {
#       type: array
#       hidden: yes
#       }

#       measure: similarity_score {
#       type: number
#       hidden: yes
#       sql: ${similar_movies.similarity_score} ;;
#   }

#   measure: top_10_similar_movies {
#     type: number
#     sql: ${similarity_score} ;;
#     value_format_name: "decimal_2"
#   }

#   # Optional: Include additional dimensions and measures as needed for your analysis
#   # ...

#   # Explore: Use this view in an explore to make it accessible in Looker's UI
#   explore: movie_recommendations {
#     description: "Movie Recommendations based on Cosine Similarity"
#     label: "Movie Recommendations"
#     join: inner
#     sql_table_name: movie_recommendations
#     view_name: movie_recommendations
#   }
# }

# idxs - series_title & index
# cosine_sim - series__title
# tfidf - index
