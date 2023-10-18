public class RowViewModel
{
    // Properties to hold data for each row
    public int SomeProperty { get; set; }
    // ... other properties
}


public class PaginatedRowsViewModel
{
    public List<RowViewModel> Rows { get; set; }
    public int CurrentPage { get; set; }
    public int TotalPages { get; set; }
    // ... other pagination properties
}

public PaginatedRowsViewModel GetData(int pageNumber, int pageSize = 100) 
{
    var paginatedVM = new PaginatedRowsViewModel();
    paginatedVM.Rows = new List<RowViewModel>();

    using (SqlConnection connection = new SqlConnection(connectionString))
    {
        using (SqlCommand cmd = new SqlCommand("YourStoredProcedure", connection))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@PageNumber", SqlDbType.Int).Value = pageNumber;
            cmd.Parameters.Add("@PageSize", SqlDbType.Int).Value = pageSize;
            // ... other parameters

            connection.Open();
            using (SqlDataReader reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    var row = new RowViewModel
                    {
                        SomeProperty = reader.GetInt32(reader.GetOrdinal("SomeProperty"))
                        // ... populate other properties
                    };
                    paginatedVM.Rows.Add(row);
                }

                paginatedVM.CurrentPage = pageNumber;
                // If your stored procedure returns total record count, set TotalPages:
                // paginatedVM.TotalPages = (int)Math.Ceiling((double)totalRecordCount / pageSize);
            }
        }
    }
    return paginatedVM;
}
