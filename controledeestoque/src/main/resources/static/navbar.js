function toggleSidebar() {
  const sidebar = document.getElementById('mySidebar');
  const mainContent = document.querySelector('.main-content');

  if (sidebar.style.width === '0px') {
    sidebar.style.width = '141px';
    mainContent.style.marginLeft = '161px'; // Adjust as needed
    mainContent.style.width = 'calc(100% - 181px)'; // Adjust as needed
  } else {
    sidebar.style.width = '0px';
    mainContent.style.marginLeft = '20px';
    mainContent.style.width = 'calc(100% - 40px)'; // Adjust as needed
  }
}