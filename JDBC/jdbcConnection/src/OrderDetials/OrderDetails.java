package OrderDetials;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jdbcConnection.JDBCConnection;

/*
 * Class to retrieve information of orders from user Id
 * 
 */
public class OrderDetails {
	private Connection connection;
	private List<OrdersDetailsPOJO> resultList = new ArrayList<OrdersDetailsPOJO>() ;

	/**
	 * Method to get the Orders details of the given user Id
	 * 
	 * @param user
	 *            Id as integer
	 */
	public List<OrdersDetailsPOJO> getOrderDetailsOfUser(int userId)
			throws SQLException {

		connection = JDBCConnection.getDatabaseConnection("StoreFront", "root",
				"tiger");
		// query format
		String queryToGetOrderDetails = "SELECT Order_Id, Order_Date, Order_Amount"
				+ " FROM Orders WHERE Order_Status LIKE \"%shipped%\" AND User_Id="
				+ userId+" ORDER BY Order_Date DESC";

		PreparedStatement preparedStatement = connection
				.prepareStatement(queryToGetOrderDetails);
		// check if resultSet is empty or not
		if (resultList != null) {
			resultList.clear();
		}
		// executing the query
		ResultSet resultSet = preparedStatement.executeQuery();

		if (resultSet.next()) {
			resultSet.previous();
			while (resultSet.next()) {
				resultList.add(new OrdersDetailsPOJO(resultSet
						.getString("Order_Id"), resultSet
						.getString("Order_Date"), resultSet
						.getString("Order_Amount")));
			}
		} else {
			System.out.println("No Orders information for this User !\n");
		}
		
		connection.close();
		return this.resultList;
	}
}