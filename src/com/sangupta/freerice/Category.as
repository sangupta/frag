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
	
	import com.sangupta.freerice.subject.Algebra;
	import com.sangupta.freerice.subject.Capitals;
	import com.sangupta.freerice.subject.Countries;
	import com.sangupta.freerice.subject.EnglishVocab;
	import com.sangupta.freerice.subject.ISubject;
	import com.sangupta.freerice.subject.Multiply;
	import com.sangupta.freerice.subject.Paintings;
	import com.sangupta.freerice.subject.PeriodicTable;

	/**
	 * 
	 * @author Sandeep Gupta
	 * @since 19 Sep 2011
	 */
	public class Category {
		
		public static const ENGLISH_VOCAB:ISubject = new EnglishVocab();
		
		public static const MULTIPLY:ISubject = new Multiply();
		
		public static const PERIODIC_TABLE:ISubject = new PeriodicTable();
		
		public static const ALGEBRA:ISubject = new Algebra();
		
		public static const CAPITALS:ISubject = new Capitals();
		
		private static const COUNTRIES:ISubject = new Countries();
		
		private static const PAINTINGS:ISubject = new Paintings();
		
		public static function getCategory(category:String):ISubject {
			if(category.indexOf('English Vocabulary') != -1) {
				return ENGLISH_VOCAB;
			} else if (category.indexOf('Multiplication Table') != -1) {
				return MULTIPLY;
			} else if(category.indexOf('Algebra') != -1) {
				return ALGEBRA;
			} else if(category.indexOf('Chemical Symbols') != -1) {
				return PERIODIC_TABLE;
			} else if(category.indexOf('World Capitals') != -1) {
				return CAPITALS;
			} else if(category.indexOf('Countries') != -1) {
				return COUNTRIES;
			} else if(category.indexOf('Paintings') != -1) {
				return PAINTINGS;
			}  
			
			return null;
		}
	}
}