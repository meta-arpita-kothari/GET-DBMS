package DeleteProduct;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jdbcConnection.JDBCConnection;

/*
 * Class containing method to delete products not ordered in last one year
 * 
 */
public class DeleteProduct {
	private Connection connection;

	/**
	 * Method deletes the Products which are not ordered from 1 year
	 * 
	 * @return number of products status updated
	 */
	public int deleteProductsNotPurchased() throws SQLException {

		connection = JDBCConnection.getDatabaseConnection("StoreFront", "root",
				"tiger");

		int result = 0;
		String queryToDeleteProduct = "UPDATE Product SET Status='INACTIVE' "
				+ "WHERE Product_Id NOT IN (SELECT oi.Product_Id FROM "
				+ "Order_Items oi LEFT JOIN Orders o ON oi.Order_Id = o.Order_Id "
				+ "WHERE DATEDIFF(now(),o.Order_Date)<365)";

		

		try{
			PreparedStatement preparedStatement = connection
					.prepareStatement(queryToDeleteProduct);
			
			connection.setAutoCommit(false);
			result = preparedStatement.executeUpdate();
			connection.commit();
		} catch (SQLException se){
			System.out.println("SQL Exception occurred !");
			connection.rollback();
		}
		

		return result;
	}
}
