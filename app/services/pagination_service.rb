# frozen_string_literal: true

class PaginationService
  def initialize(collection, page)
    @collection = collection
    @batch = collection.page(page)
  end

  def paginate
    { total_records: @collection.count,
      records_per_page: @batch.limit_value,
      total_pages: @batch.total_pages,
      current_page: @batch.current_page,
      next_page: @batch.next_page,
      prev_page: @batch.prev_page,
      is_first_page: @batch.first_page?,
      is_last_page: @batch.last_page?,
      out_of_range: @batch.out_of_range? }
  end
end
