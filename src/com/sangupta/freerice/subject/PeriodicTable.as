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

package com.sangupta.freerice.subject {
	
	import com.sangupta.freerice.DBManager;
	
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	
	import mx.utils.StringUtil;

	/**
	 * 
	 * @author Sandeep Gupta
	 * @since 19 Sep 2011
	 */
	public class PeriodicTable extends BaseSubject {
		
		override public function getAnswer(question:String):String {
			question = StringUtil.trim(question);
			var statement:SQLStatement = DBManager.getStatement('SELECT * FROM periodicTable WHERE element=:element');
			statement.parameters[":element"] = question;
			statement.execute();
			var result:SQLResult = statement.getResult();
			if(result != null && result.data != null) {
				return result.data[0].elementCode;
			}

			return null;
		}
		
		override public function saveAnswer(question:String, answer:String):void {
			try {
				var statement:SQLStatement = DBManager.getStatement('INSERT INTO periodicTable (element, elementCode) VALUES (:element, :elementCode)');
				statement.parameters[":element"] = question;
				statement.parameters[":elementCode"] = answer;
				statement.execute();
			} catch(e:Error) {
				trace('error saving question: ' + question + ' with answer: ' + answer);
			}
		}
	}
}