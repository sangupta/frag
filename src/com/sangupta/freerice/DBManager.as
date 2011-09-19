/**
 *
 * Free Rice Avant Garde - A Bot Experiment
 * Copyright (C) 2011, Sandeep Gupta
 * http://www.sangupta.com/projects/frag
 *
 * The file is licensed under the the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

package com.sangupta.freerice {
	
	import flash.data.SQLConnection;
	import flash.data.SQLMode;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.filesystem.File;

	/**
	 * Database related functions.
	 * 
	 * @author Sandeep Gupta
	 * @since 19 Sep 2011
	 */
	public class DBManager {
		
		private static const DB_FILENAME:String = 'app-storage:/freerice.db';
		
		private var dbFile:File = null
		
		private static var connection:SQLConnection = null;

		protected static function initialize():void {
			if(connection == null) {
				// create a new SQL connection object first
				connection = new SQLConnection();
				
				var dbFile:File = new File(DB_FILENAME);
				
				// SQLMode.CREATE makes sure that it creates a new database file
				// if one was not already present
				// in case one exists, this just opens a pure connection
				connection.open(dbFile , SQLMode.CREATE);
				
				// create the database tables if not already
				createDatabaseTables();
				
			}
		}
		
		public static function createDatabaseTables():void {
			executeSQLQuery("CREATE TABLE IF NOT EXISTS periodicTable (" +
				"   ID       		INTEGER PRIMARY KEY AUTOINCREMENT," +
				"   elementCode		TEXT NOT NULL," +
				"   element      	TEXT NOT NULL," +
				"	UNIQUE(element), " +
				"	UNIQUE(elementCode)" +
				")");
			
			executeSQLQuery("CREATE TABLE IF NOT EXISTS capitals (" +
				"   ID       		INTEGER PRIMARY KEY AUTOINCREMENT," +
				"   country			TEXT NOT NULL," +
				"   capital      	TEXT NOT NULL," +
				"	UNIQUE(country), " +
				"	UNIQUE(capital)" +
				")");

			executeSQLQuery("CREATE TABLE IF NOT EXISTS vocab (" +
				"   ID       		INTEGER PRIMARY KEY AUTOINCREMENT," +
				"   word			TEXT NOT NULL," +
				"   meaning      	TEXT NOT NULL," +
				"	UNIQUE(word), " +
				"	UNIQUE(word, meaning)" +
				")");

			executeSQLQuery("CREATE TABLE IF NOT EXISTS countries (" +
				"   ID       		INTEGER PRIMARY KEY AUTOINCREMENT," +
				"   country			TEXT NOT NULL," +
				"   image      		TEXT NOT NULL," +
				"	UNIQUE(image), " +
				"	UNIQUE(country)" +
				")");
			
			executeSQLQuery("CREATE TABLE IF NOT EXISTS paintings (" +
				"   ID       		INTEGER PRIMARY KEY AUTOINCREMENT," +
				"   name			TEXT NOT NULL," +
				"   artist 			TEXT NOT NULL," +
				"	UNIQUE(name), " +
				"	UNIQUE(name, artist)" +
				")");
			
		}

		public static function executeSQLQuery(statement:String):SQLResult {
			if(connection == null) {
				initialize();
			}
			
			if(connection != null && connection.connected && statement != null && statement.length > 0) {
				try {
					var sqlStatement:SQLStatement = new SQLStatement();
					sqlStatement.sqlConnection = connection;
					sqlStatement.text = statement ;
					sqlStatement.execute();
					return sqlStatement.getResult();
				} catch(e:Error) {
					trace("Error executing DB statement: " + statement + "\nError caught: " + e.toString());
				}
			}
			return null;
		}

		public static function getStatement(query:String):SQLStatement {
			var statement:SQLStatement = new SQLStatement();
			if(connection == null) {
				initialize();
			}
			statement.sqlConnection = connection;
			statement.text = query;
			return statement;
		}

	}
}
