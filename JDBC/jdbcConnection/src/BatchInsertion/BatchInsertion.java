package BatchInsertion;

import java.time.format.DateTimeFormatter;
import java.time.LocalDateTime;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jdbcConnection.JDBCConnection;

/*
 * Class containing method to insert batch records
 * 
 */
public class BatchInsertion {
	private int[] productIdList = { 4,4 };
	final int batchSize = 5;

	private Connection connection;

	/**
	 * Method to insert Batch data to the images table
	 * 
	 * @return count of record inserted
	 */
	public int insertBatchIntoImageTable() throws SQLException {

		connection = JDBCConnection.getDatabaseConnection("StoreFront", "root",
				"tiger");
		
		int result =0;
		int count = 0; // to get how many rows are inserted
		String queryForImageBatchInsertion = "INSERT INTO IMAGES(Product_Id,Image_URL) VALUES (?,?)";
		
		try {
			
			PreparedStatement preparedStatement = connection
					.prepareStatement(queryForImageBatchInsertion);
			connection.setAutoCommit(false);
			
			for (int id : productIdList) {
				preparedStatement.setInt(1, id);
				preparedStatement.setString(2, "urlImage" + id + "_"
						+ getCurrentDate());
				preparedStatement.addBatch();

//				if (++count % batchSize == 0) {
//					preparedStatement.executeBatch();
//				}
			}
			int[] noOfRowsUpdated = preparedStatement.executeBatch(); // executing remaining records
			result = noOfRowsUpdated.length;
			connection.commit();
		} catch (SQLException se) {
			System.out.println("SQL Exception occurred !"+se.getErrorCode()+" : " +se.getMessage());
			connection.rollback();
		}
		
		connection.close();
		return result;
	}

	private String getCurrentDate() {

		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS");
		LocalDateTime now = LocalDateTime.now();

		return dtf.format(now);
	}
}