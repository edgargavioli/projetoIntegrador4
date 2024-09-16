document.addEventListener('DOMContentLoaded', function() {

  // Display content1 by default
    var tab1 = document.getElementById('tab1');
    var tab2 = document.getElementById('tab2');
    var container1 = document.querySelector('#content1').parentNode;
    var container2 = document.querySelector('#content2').parentNode;

    // Display container1 by default and make tab1 active
    container1.style.display = 'flex';
    tab1.classList.add('active');

    tab1.addEventListener('click', function() {
      container1.style.display = 'flex';
      container2.style.display = 'none';
      tab1.classList.add('active');
      tab2.classList.remove('active');
    });

    tab2.addEventListener('click', function() {
      container1.style.display = 'none';
      container2.style.display = 'flex';
      tab1.classList.remove('active');
      tab2.classList.add('active');
    }); 
  
});