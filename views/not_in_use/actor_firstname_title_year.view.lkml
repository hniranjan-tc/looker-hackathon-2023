# The name of this view in Looker is "Actor Firstname Title Year"
view: actor_firstname_title_year {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `lookerdata.imdb.actor_firstname_title_year` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Full Name" in Explore.

  dimension: full_name {
    type: string
    sql: ${TABLE}.full_name ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_year {
    type: sum
    sql: ${year} ;;  }
  measure: average_year {
    type: average
    sql: ${year} ;;  }
  measure: count {
    type: count
    drill_fields: [full_name, name]
  }
}
