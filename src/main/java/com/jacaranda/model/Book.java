package com.jacaranda.model;

import java.time.LocalDate;
import java.util.Objects;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * @author sandra
 * Esta clase crea un libro
 */
@Entity
@Table(name="BOOK") //mapeamos la clase con la tabla correspondiente en la base de datos
public class Book {
	@Id //indicamos el atributo que será el identificador en la base de datos
	private String isbn;
	private String title;
	private String author;
	@Column(name = "published_date") //mapeamos un atributo cuyo nombre es diferente en la base de datos
	private LocalDate publishedDate;
	private int quantity;
	private double price;
	private boolean stock;
	@ManyToOne //indicamos la relación que van a tener los libros con los géneros
	@JoinColumn(name="genre")
	private Genre genre;
	
	
	
	/**
	 * Constructor vacío
	 */
	public Book() {
		super();
	}
	
	/**
	 * Constructor sin asignación del ISBN ni género(genre), para la validación de la modificación de campos
	 * @param title el título del libro
	 * @param author el autor del libro
	 * @param publishedDate la fecha de publicación del libro
	 * @param quantity la cantidad de libros
	 * @param price el precio del libro
	 * @throws BookException se lanza si los campos no cumplen los requerimientos de los setters
	 */
	public Book(String title, String author, LocalDate publishedDate, int quantity, double price) throws BookException {
		super();
		this.setTitle(title);
		this.setAuthor(author);
		this.setPublishedDate(publishedDate);
		this.setQuantity(quantity);
		this.setPrice(price);
	}
	
	/**
	 * Constructor sin el parámetro stock, que se asigna según el atributo quantity, ni el género(genre)
	 * @param isbn el ISBN del libro
	 * @param title el título del libro
	 * @param author el autor del libro
	 * @param publishedDate la fecha de publicación del libro
	 * @param quantity la cantidad de libros
	 * @param price el precio del libro
	 * @throws BookException se lanza si los campos no cumplen los requerimientos de los setters
	 */
	public Book(String isbn, String title, String author, LocalDate publishedDate, int quantity, double price) throws BookException {
		super();
		this.setIsbn(isbn);
		this.setTitle(title);
		this.setAuthor(author);
		this.setPublishedDate(publishedDate);
		this.setQuantity(quantity);
		this.setPrice(price);
	}
	
	
	/**
	 * Constructor con todos los parámetros
	 * @param isbn el ISBN del libro
	 * @param title el título del libro
	 * @param author el autor del libro
	 * @param publishedDate la fecha de publicación del libro
	 * @param quantity la cantidad de libros
	 * @param price el precio del libro
	 * @param genre un objeto de tipo género
	 * @throws BookException se lanza si los campos no cumplen los requerimientos de los setters
	 * o el objeto género es nulo
	 */
	public Book(String isbn, String title, String author, LocalDate publishedDate, int quantity, double price,
			Genre genre) throws BookException {
		super();
		this.setIsbn(isbn);
		this.setTitle(title);
		this.setAuthor(author);
		this.setPublishedDate(publishedDate);
		this.setQuantity(quantity);
		this.setPrice(price);
		if(genre!=null) {
			this.genre = genre;
		}else {
			throw new BookException ("El genero no puede ser nulo");
		}
	}

	/**
	 * Conjunto de métodos get de los atributos
	 * @return atributo correspondiente
	 */
	public String getIsbn() {
		return isbn;
	}


	public String getTitle() {
		return title;
	}


	public String getAuthor() {
		return author;
	}


	public LocalDate getPublishedDate() {
		return publishedDate;
	}


	public int getQuantity() {
		return quantity;
	}


	public double getPrice() {
		return price;
	}
	

	public boolean isStock() {
		return stock;
	}

	/**
	 * Método que se usa para que si el stock del objeto Libro es true, lo devuelva como un char 'S'
	 * y si es false, lo devuelva como un char 'N'
	 */
	public char getStockYN() {
		char stockLetter = 'N';
		if(this.stock) {
			stockLetter = 'S';
		}
		return stockLetter;
	}
	
	/**
	 * Método que comprueba que el ISBN es correcto o no.
	 * @param isbn el ISBN del libro
	 * @throws BookException cuando el ISBN no cumple la expresión regular.
	 */
	public void setIsbn(String isbn) throws BookException {
		String expression = "[0-9]{10}";
		if(isbn.matches(expression)) {
			this.isbn = isbn;
		}else {
			throw new BookException("ISBN incorrecto");
		}
	}

	/**
	 * Método que comprueba que la fecha de publicación del libro sea anterior a la fecha actual
	 * @param publishedDate la fecha de publicación del libro
	 * @throws BookException lanza la excepción cuando la fecha es posterior o igual a la fecha actual
	 */
	public void setPublishedDate(LocalDate publishedDate) throws BookException {
		if(!publishedDate.isAfter(LocalDate.now())) {
			this.publishedDate = publishedDate;
		}else {
			throw new BookException("Fecha incorrecta");
		}
	}

	/**
	 * Método que comprueba que la cantidad de libros sea mayor o igual a 0
	 * y asigna el stock conforme a la cantidad de libros
	 * @param quantity la cantidad de libros
	 * @throws BookException lanza la excepción cuando la cantidad es inferior a 0
	 */
	public void setQuantity(int quantity) throws BookException {
		if(quantity>0) {
			this.quantity = quantity;
			this.stock = true;
		}else if(quantity==0){
			this.quantity = quantity;
			this.stock = false;
		}else {
			throw new BookException("Cantidad incorrecta");
		}
	}

	/**
	 * Método que comprueba que el precio sea mayor a 0.0
	 * @param price el precio del libro
	 * @throws BookException lanza la excepción cuando el precio es inferior o igual a 0.0
	 */
	public void setPrice(double price) throws BookException {
		if(price>0.0) {
			this.price = price;
		}else {
			throw new BookException("Precio incorrecto");
		}
	}
	
	/**
	 * Método que comprueba que el título del libro no esté vacío o solo contenga espacios en blanco
	 * @param title el título del libro
	 * @throws BookException lanza la excepción cuando el título está vacío o solo contiene espacios en blanco
	 */
	public void setTitle(String title) throws BookException {
		if(title == null || title.isBlank()) {
			throw new BookException("El titulo no puede estar vacio"); //Sin tildes porque sino las entiende el jsp al saltar el error
		}else {
			this.title = title;
		}
	}
	
	/**
	 * Método que comprueba que el autor del libro no esté vacío o solo contenga espacios en blanco
	 * @param author el autor del libro
	 * @throws BookException lanza la excepción cuando el autor está vacío o solo contiene espacios en blanco
	 */
	public void setAuthor(String author) throws BookException {
		if(author == null || author.isBlank()) {
			throw new BookException("El autor no puede estar vacio"); //Sin tildes porque sino las entiende el jsp al saltar el error
		}else {
			this.author = author;
		}
	}
	
	
	/**
	 * Método que obtiene un objeto género de un libro
	 * @return el objeto género
	 */
	public Genre getGenre() {
		return genre;
	}

	/**
	 * Método que comprueba que el género del libro no esté vacío 
	 * @param genre el género del libro, objeto de la clase Genre
	 * @throws BookException lanza la excepción cuando el género está vacío 
	 */
	public void setGenre(Genre genre) throws BookException {
		if(genre == null) {
			throw new BookException("El genero no puede ser nulo"); //Sin tildes porque sino las entiende el jsp al saltar el error
		}else {
			this.genre = genre;
		}
		
	}

	/**
	 * Método hashCode, según el ISBN
	 */
	@Override
	public int hashCode() {
		return Objects.hash(isbn);
	}

	/**
	 * Método equals. Dos libros son iguales cuando tienen el mismo ISBN
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Book other = (Book) obj;
		return Objects.equals(isbn, other.isbn);
	}

	
	/**
	 * Método toString
	 */
	@Override
	public String toString() {
		return "Book [isbn=" + isbn + ", title=" + title + ", author=" + author + ", publishedDate=" + publishedDate
				+ ", quantity=" + quantity + ", price=" + price + ", stock=" + stock + "]";
	}

	
}
