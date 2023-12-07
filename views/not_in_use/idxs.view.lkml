view: idxs {
  # You can specify the table name if it's different from the view name:
  sql_table_name: precise-plane-407222.imdb_dataset.idxs ;;

  dimension: series_title {
    type: string
    sql: ${TABLE}.series_title ;;
  }

  dimension: index {
    type: number
    sql: ${TABLE}.index ;;
  }
}
