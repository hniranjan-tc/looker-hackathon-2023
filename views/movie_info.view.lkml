# The name of this view in Looker is "Movie Info"
view: movie_info {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `lookerdata.imdb.movie_info` ;;
  drill_fields: [id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Info" in Explore.

  dimension: info {
    type: string
    sql: ${TABLE}.info ;;
  }

  dimension: info_type_id {
    type: number
    sql: ${TABLE}.info_type_id ;;
  }

  dimension: movie_id {
    type: number
    sql: ${TABLE}.movie_id ;;
  }
  measure: count {
    type: count
    drill_fields: [id]
  }
}
