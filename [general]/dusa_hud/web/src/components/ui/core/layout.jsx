const Layout = ({ children }) => {
  return (
    <div className="h-screen w-screen">
      <div className="w-full h-full relative">{children}</div>
    </div>
  );
};
export default Layout;
