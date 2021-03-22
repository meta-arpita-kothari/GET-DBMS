package CategoriesInParentCategory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jdbcConnection.JDBCConnection;

/*
 * Class containing method to get number of child categories
 * 
 */
public class CategoriesInParentCategory {
	private Connection connection;
	private List<CategoriesInParentCategoryPOJO> resultList = new ArrayList<CategoriesInParentCategoryPOJO>();

	/**
	 * Method to get Category title and count of its child categories
	 * 
	 * @return list of POJO consisting data
	 */
	public List<CategoriesInParentCategoryPOJO> getChildCategoryCount()
			throws SQLException {
		connection = JDBCConnection.getDatabaseConnection("StoreFront", "root",
				"tiger");

		// query string
		String queryToGetChildCategoryCount = "SELECT c.Category_Name, Count(c1.Category_Id) AS count_Of_Child FROM category c "
				+ "LEFT JOIN category c1 ON c.category_Id=c1.Parent_category "
				+ "WHERE c.Parent_category=0 GROUP BY c.category_Name "
				+ "ORDER BY c.Category_Name";

		PreparedStatement preparedStatement = connection
				.prepareStatement(queryToGetChildCategoryCount);
		// check if resultSet is empty or not
		if (resultList != null) {
			resultList.clear();
		}

		// executing query
		ResultSet resultSet = preparedStatement.executeQuery();

		if (resultSet.next()) {
			resultSet.previous();
			while (resultSet.next()) {
				resultList.add(new CategoriesInParentCategoryPOJO(resultSet
						.getString("Category_Name"), resultSet
						.getInt("count_Of_Child")));
			}
		} else {
			System.out.println("No Top Category Found !\n");
		}
		connection.close();
		return this.resultList;

	}
}