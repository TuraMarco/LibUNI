// CLASSE DI PROVA PER HIBERNATE

package it.unibo.tw.es3.test;

import it.unibo.tw.es3.beans.Autore;
import it.unibo.tw.es3.beans.Libro;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.*;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

public class TestEs3 {

	public static void main(String[] args) {

		// -------------------------------
		// distruzione e creazione tabelle
		// -------------------------------
		
		try {
			// modificare secondo necessita'
			
			Class.forName("com.ibm.db2.jcc.DB2Driver");
			String url = "jdbc:db2://diva.deis.unibo.it:50000/tw_stud";
			
			String username = "xxxx";
			String password = "xxxx";
			Connection conn = DriverManager.getConnection(url, username, password);
			Statement st = conn.createStatement();
			
			String sql;			
			try{
				sql = "DROP TABLE books";
				System.out.println(sql);
				st.executeUpdate(sql);
				System.out.println("done");
			}
			catch(Exception e){
				// drop fallisce se la tabella non esiste
				//e.printStackTrace();
			}
			
			try{
				sql = "DROP TABLE authors";
				System.out.println(sql);
				st.executeUpdate(sql);
				System.out.println("done");
			}
			catch(Exception e){
				// drop fallisce se la tabella non esiste
				//e.printStackTrace();
			}
			
			sql = "CREATE TABLE authors " +
			"( " +
				"id BIGINT NOT NULL PRIMARY KEY," + //questo non compare sull'UML dato, lo aggiungo io
				"cf CHAR(16) NOT NULL UNIQUE, " +
				"nome VARCHAR(40),  " +
				"cognome VARCHAR(40)" +
			") ";
			System.out.println(sql);	
			st.executeUpdate(sql);
			System.out.println("done");
	
			sql = "CREATE TABLE books ( " +
						"id BIGINT NOT NULL PRIMARY KEY," + //questo non compare sull'UML dato, lo aggiungo io
						"isbn CHAR(13) NOT NULL UNIQUE, " +
						"titolo VARCHAR(40),  " +
						"idAutore BIGINT REFERENCES authors" +  //questo non compare sull'UML dato, lo aggiungo io, è il riferimento agli autori
					") ";
			System.out.println(sql);
			st.executeUpdate(sql);
			System.out.println("done");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
		Session session = sessionFactory.openSession();
		Transaction tx = null;
		
		try{
			tx = session.beginTransaction();
			
			Autore autore1 = new Autore();
			autore1.setNome("Name1");
			autore1.setCognome("Surname1");
			autore1.setCf("cf11111111111111");
			session.saveOrUpdate(autore1);

			Autore autore2 = new Autore();
			autore2.setNome("Name2");
			autore2.setCognome("Surname2");
			autore2.setCf("cf22222222222222");
			session.saveOrUpdate(autore2);
			
			Libro l1 = new Libro();
			l1.setTitolo("Titolo1");
			l1.setIsbn("1111111111111");
			l1.setIdAutore(autore1.getId());
			session.saveOrUpdate(l1);
			
			Libro l2 = new Libro();
			l2.setTitolo("Titolo2");
			l2.setIsbn("2222222222222");
			l2.setIdAutore(autore1.getId());
			session.saveOrUpdate(l2);

			Libro l3 = new Libro();
			l3.setTitolo("Titolo3");
			l3.setIsbn("3333333333333");
			l3.setIdAutore(autore2.getId());
			session.saveOrUpdate(l3);
			
			Set<Libro> libri = new HashSet<Libro>();
			autore1.setLibri(libri); //perche ho mappato la relazione 1-N tra Autori e Libri con una set
			autore1.getLibri().add(l1);
			autore1.getLibri().add(l2);
			session.saveOrUpdate(autore1);
			
			tx.commit();
		}
		catch (Exception e1) {
			e1.printStackTrace();
			if (tx != null){
				try{
					tx.rollback();
				}
				catch(Exception e2){
					e2.printStackTrace();
				}
			}
		}
		finally {
			session.close();
		}
		
		// riapro una nuova sessione per effettuare la query senza che ci siano dati in cache
		session = sessionFactory.openSession();
		
		try{	
			// versione che sfrutta il mapping one-to-many
			// (richiesta dal testo!!!)
			// di default hibernate usa la modalita' lazy
			System.out.println("");
			System.out.println("versione che sfrutta il mapping one-to-many");
			
			Query query1 = session.createQuery("from "+Autore.class.getSimpleName()+" where cf = ?");
			query1.setString(0, "cf11111111111111");
			Autore retrievedAuthor = (Autore)query1.uniqueResult();
			Set<Libro> retreivedBooks = retrievedAuthor.getLibri();
			Iterator<Libro> itLibri = retreivedBooks.iterator();
			
			System.out.println("retreivedBooks.size() "+ retreivedBooks.size());
			while(itLibri.hasNext()){
				Libro libroResult = itLibri.next();
				System.out.println(libroResult.getTitolo()+" "+ libroResult.getIsbn());
			}			
			
		}
		finally {
			session.close();
		}
		
		// riapro una nuova sessione per effettuare la query senza che ci siano dati in cache
		session = sessionFactory.openSession();
		
		try{
			// versione che NON sfrutta il mapping one-to-many (due query)
			// (non richiesta dal testo; solo a scopo esemplificativo)
			// in modalita' lazy/pigro
			System.out.println();
			System.out.println("versione che NON sfrutta il mapping one-to-many (due query)");
			
			Query query1 = session.createQuery("from "+Autore.class.getSimpleName()+" where cf = ?");
			query1.setString(0, "cf11111111111111");
			Autore retrievedAuthor = (Autore)query1.uniqueResult();
			Long authorId = retrievedAuthor.getId();
			System.out.println("authorId = "+ authorId);
			
			Query query2 = session.createQuery("from "+Libro.class.getName()+" where idAutore = ?");
			query2.setLong(0, authorId);
			List<Libro> libriAutore = query2.list();
			Iterator<Libro> itLibri1 = libriAutore.iterator();
			
			System.out.println("libriAutore.size() "+ libriAutore.size());
			while(itLibri1.hasNext()){
				Libro libroResult = itLibri1.next();
				System.out.println(libroResult.getTitolo()+" "+ libroResult.getIsbn());
			}
			
		}
		finally {
			session.close();
		}
		
		// riapro una nuova sessione per effettuare la query senza che ci siano dati in cache
		session = sessionFactory.openSession();
		
		try{
		
			// versione che NON sfrutta il mapping one-to-many (una query)
			// (non richiesta dal testo; solo a scopo esemplificativo)
			// in modalita' eager/immediato
			System.out.println();
			System.out.println("versione che NON sfrutta il mapping one-to-many (una query)");
			
			Query query1 = session.createQuery("select libro " +
					"from "+Libro.class.getSimpleName()+" libro, " +
					""+Autore.class.getSimpleName()+" autore " +
					"where autore.id = libro.idAutore " +
					"and autore.cf = ? " );
			query1.setString(0, "cf11111111111111");
			List<Libro> libriAutore = query1.list();
			Iterator<Libro> itLibri = libriAutore.iterator();
			
			System.out.println("libriAutore.size() "+ libriAutore.size());
			while(itLibri.hasNext()){
				Libro libroResult = itLibri.next();
				System.out.println(libroResult.getTitolo()+" "+ libroResult.getIsbn());
			}
			
		}
		catch (Exception e1) {
			e1.printStackTrace();
		}
		finally {
			session.close();
		}
	  
	}

}
