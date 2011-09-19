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
	
	/**
	 * 
	 * @author Sandeep Gupta
	 * @since 19 Sep 2011
	 */
	public class Countries implements ISubject {
		
		public function getQuestion(document:Object):String {
			var q:Object = document.getElementById('pictureDisplay');
			var source:String = '';
			if(q.childNodes) {
				source = q.childNodes[0].src;
			}
			
			var index:int = source.lastIndexOf('/');
			if(index != -1) {
				return source.substr(index + 1);
			}
			
			throw new Error('cannot decipher question');
		}
		
		public function getAnswer(question:String):String {
			var statement:SQLStatement = DBManager.getStatement('SELECT * FROM countries WHERE image=:image');
			statement.parameters[":image"] = question;
			statement.execute();
			var result:SQLResult = statement.getResult();
			if(result != null && result.data != null) {
				return result.data[0].country;
			}
			
			return null;
		}
		
		public function saveAnswer(question:String, answer:String):void
		{
			var statement:SQLStatement = DBManager.getStatement('INSERT INTO countries (country, image) VALUES (:country, :image)');
			statement.parameters[":image"] = question;
			statement.parameters[":country"] = answer;
			statement.execute();
		}
	}
}
